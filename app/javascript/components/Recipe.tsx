import React from "react";

export type Recipe = {
  id: string;
  author: string;
  author_tip: string;
  budget: string;
  cook_time: string;
  cook_time_minutes: number;
  difficulty: string;
  image: string;
  ingredients: string[];
  name: string;
  nb_comments: string;
  people_quantity: string;
  prep_time: string;
  prep_time_minutes: number;
  rate: string;
  tags: string[];
  total_time: string;
  total_time_minutes: number;
};

/**
 * 
 * @param param0 
 * @returns 
 */
export default function Recipe({ recipe }: { recipe: Recipe }) {
  const {
    id,
    name,
    author,
    rate,
    difficulty,
    people_quantity,
    cook_time,
    author_tip,
    budget,
    prep_time,
    ingredients,
    tags,
    total_time,
    image,
    nb_comments,
  } = recipe;

  return (
    <div className="recipe-card">
      <h2>
        {name}
        <br />
        <small>{author}</small>
      </h2>
      <div style={{ display: "flex", justifyContent: "space-between" }}>
        <div>
          <p>
            Servings: {people_quantity}
            <br />
            Prep. Time: {prep_time}
            <br />
            Cook Time: {cook_time}
            <br />
            Time: {total_time}
          </p>
        </div>
        <div>
          <p>
            Difficulty: {difficulty}
            <br />
            Budget: {budget}
            <br />
            Rate: {rate}
            <br />
            Comments: {nb_comments}
          </p>
        </div>
      </div>
      <p>{author_tip}</p>
      Ingredients:
      <ul>
        {ingredients.map((ingredient: string) => (
          <li key={`${id}-${ingredient}`} >{ingredient}</li>
        ))}
      </ul>
      Tags:
      <br />
      <div className="tag-list">
        {tags.map((tag: string) => (
          <span key={`${id}-${tag}`}>{tag}</span>
        ))}
      </div>
    </div>
  );
}
