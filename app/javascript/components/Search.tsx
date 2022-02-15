import { compact, pullAt, times } from "lodash";
import React, { useState } from "react";
import useParams from "./hooks/useParams";
import TextInput from "./inputs/TextInput";

/**
 *
 * @param param0
 * @returns
 */
export default function Search() {
  const params = useParams();
  let defaultValues: string[] | [] = params.getAll(`with_ingredients[]`);
  const [inputs, setInputs] = useState<string[] | []>(defaultValues);

  return (
    <form id="recipe-search-form" key="recipe-search-form">
      <fieldset>
        <a
          className="button"
          style={{ marginBottom: 12 }}
          onClick={() => setInputs([...inputs, ""])}
        >
          Add an ingredient to search..
        </a>
        {times(inputs.length, (i: number) => (
          <TextInput
            placeholder="Type an ingredient.."
            defaultValue={inputs[i]}
            id={`with_ingredients-${i}`}
            name="with_ingredients[]"
            key={`with_ingredients-${i}`}
            onClick={() => {
              pullAt(inputs, [i]);
              setInputs([...inputs]);
            }}
          />
        ))}
      </fieldset>

      {inputs.length > 0 && (
        <button className="button" type="submit">
          Search
        </button>
      )}
    </form>
  );
}
