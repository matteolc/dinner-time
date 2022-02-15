import useParams from "./useParams";

export default function usePagination({
  pages,
  page,
}: {
  pages: number;
  page: number;
}) {
  let params = useParams();
  params.delete("page");
  page < pages
    ? params.append("page", `${page + 1}`)
    : params.append("page", `1`);
  return params;
}
