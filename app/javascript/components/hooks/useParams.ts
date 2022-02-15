export default function useParams() {
  const search = new URL(window.location.href).search;
  const params = new URLSearchParams(search);
  return params;
}
