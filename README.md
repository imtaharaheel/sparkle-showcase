# Welcome to your Lovable project

## Project info

**URL**: https://lovable.dev/projects/REPLACE_WITH_PROJECT_ID

## How can I edit this code?

There are several ways of editing your application.

**Use Lovable**

Simply visit the [Lovable Project](https://lovable.dev/projects/REPLACE_WITH_PROJECT_ID) and start prompting.

Changes made via Lovable will be committed automatically to this repo.

**Use your preferred IDE**

If you want to work locally using your own IDE, you can clone this repo and push changes. Pushed changes will also be reflected in Lovable.

The only requirement is having Node.js & npm installed - [install with nvm](https://github.com/nvm-sh/nvm#installing-and-updating)

Follow these steps:

```sh
# Step 1: Clone the repository using the project's Git URL.
git clone <YOUR_GIT_URL>

# Step 2: Navigate to the project directory.
cd <YOUR_PROJECT_NAME>

# Step 3: Install the necessary dependencies.
npm i

# Step 4: Start the development server with auto-reloading and an instant preview.
npm run dev
```

**Edit a file directly in GitHub**

- Navigate to the desired file(s).
- Click the "Edit" button (pencil icon) at the top right of the file view.
- Make your changes and commit the changes.

**Use GitHub Codespaces**

- Navigate to the main page of your repository.
- Click on the "Code" button (green button) near the top right.
- Select the "Codespaces" tab.
- Click on "New codespace" to launch a new Codespace environment.
- Edit files directly within the Codespace and commit and push your changes once you're done.

## What technologies are used for this project?

This project is built with:

- Vite
- TypeScript
- React
- shadcn-ui
- Tailwind CSS

## How can I deploy this project?

### Deploy to GitHub Pages

This project is configured for automatic deployment to GitHub Pages using GitHub Actions.

**Initial Setup:**

1. Push your code to a GitHub repository
2. Go to your repository on GitHub
3. Navigate to **Settings** → **Pages**
4. Under **Source**, select **GitHub Actions** (not "Deploy from a branch")
5. The workflow will automatically deploy when you push to the `main` branch

**Manual Deployment:**

You can also trigger a manual deployment by:
- Going to **Actions** tab in your repository
- Selecting the "Deploy to GitHub Pages" workflow
- Clicking **Run workflow**

### Connect Custom Domain (saimenterprise.com)

The project is already configured with a `CNAME` file for your custom domain.

**DNS Configuration on Hostinger:**

1. Log in to your Hostinger account
2. Go to **Domains** → **Manage** → **DNS / Name Servers**
3. Add the following DNS records:

   **For root domain (saimenterprise.com):**
   - Type: `A`
   - Name: `@` (or leave blank)
   - Value: `185.199.108.153`
   - TTL: `3600` (or default)

   - Type: `A`
   - Name: `@` (or leave blank)
   - Value: `185.199.109.153`
   - TTL: `3600` (or default)

   - Type: `A`
   - Name: `@` (or leave blank)
   - Value: `185.199.110.153`
   - TTL: `3600` (or default)

   - Type: `A`
   - Name: `@` (or leave blank)
   - Value: `185.199.111.153`
   - TTL: `3600` (or default)

   **For www subdomain (www.saienterprise.com):**
   - Type: `CNAME`
   - Name: `www`
   - Value: `your-username.github.io` (replace with your GitHub username)
   - TTL: `3600` (or default)

**GitHub Pages Settings:**

1. After DNS is configured, go to your repository **Settings** → **Pages**
2. Under **Custom domain**, enter: `saimenterprise.com`
3. Check **Enforce HTTPS** (this will be available after DNS propagation)

**Note:** DNS changes can take 24-48 hours to propagate. You can verify DNS propagation using tools like [whatsmydns.net](https://www.whatsmydns.net/).

**Alternative: Using CNAME record for root domain**

Some DNS providers (like Hostinger) support CNAME flattening or ALIAS records for the root domain. If available, you can use:
- Type: `CNAME` or `ALIAS`
- Name: `@`
- Value: `your-username.github.io`
