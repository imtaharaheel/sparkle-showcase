-- Inventory admin schema: profiles, categories, products, storage, RLS.
-- After push: create admin user in Dashboard Auth, then:
--   update public.profiles set is_admin = true where id = '<user uuid>';

-- ---------------------------------------------------------------------------
-- Tables
-- ---------------------------------------------------------------------------

create table public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  is_admin boolean not null default false,
  created_at timestamptz not null default now()
);

alter table public.profiles enable row level security;

create policy "Users read own profile"
  on public.profiles
  for select
  to authenticated
  using (auth.uid() = id);

create table public.categories (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  slug text not null unique,
  created_at timestamptz not null default now()
);

alter table public.categories enable row level security;

create table public.inventory_products (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  description text not null default '',
  price numeric(12, 2) not null check (price >= 0),
  stock_quantity integer not null default 0 check (stock_quantity >= 0),
  category_id uuid not null references public.categories (id) on delete restrict,
  image_path text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index inventory_products_category_id_idx on public.inventory_products (category_id);
create index inventory_products_name_idx on public.inventory_products (name);

alter table public.inventory_products enable row level security;

-- ---------------------------------------------------------------------------
-- Admin helper (SECURITY DEFINER reads profiles; avoids RLS recursion)
-- ---------------------------------------------------------------------------

create or replace function public.is_inventory_admin()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select coalesce(
    (select p.is_admin from public.profiles p where p.id = auth.uid()),
    false
  );
$$;

grant execute on function public.is_inventory_admin() to authenticated;

-- ---------------------------------------------------------------------------
-- RLS: categories & inventory_products (admins only)
-- ---------------------------------------------------------------------------

create policy "Admins manage categories"
  on public.categories
  for all
  to authenticated
  using (public.is_inventory_admin())
  with check (public.is_inventory_admin());

create policy "Admins select inventory_products"
  on public.inventory_products
  for select
  to authenticated
  using (public.is_inventory_admin());

create policy "Admins insert inventory_products"
  on public.inventory_products
  for insert
  to authenticated
  with check (public.is_inventory_admin());

create policy "Admins update inventory_products"
  on public.inventory_products
  for update
  to authenticated
  using (public.is_inventory_admin())
  with check (public.is_inventory_admin());

create policy "Admins delete inventory_products"
  on public.inventory_products
  for delete
  to authenticated
  using (public.is_inventory_admin());

-- ---------------------------------------------------------------------------
-- updated_at trigger
-- ---------------------------------------------------------------------------

create or replace function public.set_inventory_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create trigger inventory_products_set_updated_at
  before update on public.inventory_products
  for each row
  execute function public.set_inventory_updated_at();

-- ---------------------------------------------------------------------------
-- Auth: new user -> profile row
-- ---------------------------------------------------------------------------

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, is_admin)
  values (new.id, false);
  return new;
end;
$$;

create trigger on_auth_user_created
  after insert on auth.users
  for each row
  execute function public.handle_new_user();

-- ---------------------------------------------------------------------------
-- Storage bucket (public read for simple thumbnails)
-- ---------------------------------------------------------------------------

insert into storage.buckets (id, name, public)
values ('product-images', 'product-images', true)
on conflict (id) do nothing;

-- storage.objects policies
create policy "Public read product images"
  on storage.objects
  for select
  using (bucket_id = 'product-images');

create policy "Admins upload product images"
  on storage.objects
  for insert
  to authenticated
  with check (
    bucket_id = 'product-images'
    and public.is_inventory_admin()
  );

create policy "Admins update product images"
  on storage.objects
  for update
  to authenticated
  using (
    bucket_id = 'product-images'
    and public.is_inventory_admin()
  )
  with check (
    bucket_id = 'product-images'
    and public.is_inventory_admin()
  );

create policy "Admins delete product images"
  on storage.objects
  for delete
  to authenticated
  using (
    bucket_id = 'product-images'
    and public.is_inventory_admin()
  );

-- ---------------------------------------------------------------------------
-- Seed categories (aligned with showcase catalog)
-- ---------------------------------------------------------------------------

insert into public.categories (name, slug) values
  ('Keyboard', 'keyboard'),
  ('Mouse', 'mouse'),
  ('Headset', 'headset'),
  ('Combo', 'combo'),
  ('Speaker', 'speaker'),
  ('Microphone', 'microphone'),
  ('Accessory', 'accessory'),
  ('iPad', 'ipad'),
  ('Apple Pencil', 'apple-pencil'),
  ('iPad Accessories', 'ipad-accessories'),
  ('Mac', 'mac'),
  ('Laptop', 'laptop')
on conflict (slug) do nothing;

-- API access (RLS still applies)
grant usage on schema public to authenticated;
grant select on public.profiles to authenticated;
grant select, insert, update, delete on public.categories to authenticated;
grant select, insert, update, delete on public.inventory_products to authenticated;
