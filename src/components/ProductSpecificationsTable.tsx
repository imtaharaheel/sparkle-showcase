export interface ProductSpecification {
  label: string;
  value: string;
}

interface ProductSpecificationsTableProps {
  specifications: ProductSpecification[];
}

export function ProductSpecificationsTable({ specifications }: ProductSpecificationsTableProps) {
  if (specifications.length === 0) {
    return null;
  }

  return (
    <div className="overflow-hidden rounded-xl border border-border bg-card shadow-sm">
      <table className="w-full text-sm">
        <caption className="sr-only">Technical specifications</caption>
        <tbody>
          {specifications.map((spec, index) => (
            <tr
              key={`${spec.label}-${index}`}
              className={index % 2 === 0 ? "bg-secondary/40" : "bg-card"}
            >
              <th
                scope="row"
                className="w-[34%] border-b border-border/60 px-4 py-3 text-left align-top font-semibold text-foreground sm:px-5 sm:py-3.5"
              >
                {spec.label}
              </th>
              <td className="border-b border-border/60 px-4 py-3 align-top text-muted-foreground sm:px-5 sm:py-3.5">
                {spec.value}
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
