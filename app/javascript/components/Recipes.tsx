import React from "react";
import Recipe from "./Recipe";
import type { Recipe as RecipeType } from "./Recipe";
import Pagination from "./Pagination";

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
