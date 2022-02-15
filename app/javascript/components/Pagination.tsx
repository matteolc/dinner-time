// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React, { ReactChildren } from "react";
import Recipe from "./Recipe";
import type { Recipe as RecipeType } from "./Recipe";
import usePagination from "./hooks/usePagination";
import { min } from "lodash";

/**
 *
 * @param param0
 * @returns
 */
export default function Pagination({
  count,
  items,
  pages,
  page,
  children,
}: {
  count: number;
  items: number;
  children: JSX.Element;
  pages: number;
  page: number;
}) {
  const params = usePagination({ pages, page });

  return count > 0 ? (
    <>
      <div
        style={{
          display: "flex",
          flexDirection: "row",
          justifyContent: "space-between",
          marginBottom: 12,
        }}
      >
        <div className="button" aria-disabled>
          Showing {1 + (page - 1) * items}-{min([1 + page * items, count])} of{" "}
          {count} {count > 1 ? "recipes" : "recipe"}
        </div>
        <div className="button" aria-disabled>
          Page {page} of {pages}
        </div>
      </div>

      {children}

      {count > items && (
        <a
          rel="preload"
          href={`/recipes?${params.toString()}`}
          className="button"
          style={{ width: "100%", marginTop: 24 }}
          type="submit"
        >
          {page < pages ? "Show more.." : "Back to first recipes.."}
        </a>
      )}
    </>
  ) : (
    <div className="button" aria-disabled>
      No recipes!
    </div>
  );
}
