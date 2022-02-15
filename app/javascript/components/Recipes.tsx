// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from "react";
import Recipe from "./Recipe";
import type { Recipe as RecipeType } from "./Recipe";
import Pagination from "./Pagination";

/**
 *
 * @param param0
 * @returns
 */
export default function Recipes({
  recipes,
  count,
  items,
  pages,
  page,
}: {
  recipes: RecipeType[];
  items: number;
  count: number;
  pages: number;
  page: number;
}) {
  return (
    <Pagination count={count} items={items} pages={pages} page={page}>
      <div className="recipes-list">
        {recipes.map((recipe: RecipeType) => (
          <Recipe key={recipe.id} recipe={recipe} />
        ))}
      </div>
    </Pagination>
  );
}
