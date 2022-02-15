import React from "react";
import TextArrayInput from "./inputs/TextArray";

/**
 *
 * @param param0
 * @returns
 */
export default function Search() {
  return (
    <form id="recipe-search-form" key="recipe-search-form">
      <TextArrayInput
        label="Search for recipes with ingredients.."
        name="with_ingredients"
        placeholder="Type an ingredient.."
        cardinality={5}
      />

      <button className="button" type="submit">
        Search
      </button>
    </form>
  );
}
