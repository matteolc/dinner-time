import { isEmpty } from "lodash";
import React, { useState } from "react";
import useParams from "./hooks/useParams";


export default function Search() {
  const params = useParams();
  const defaultValue: string | null = params.get("q");
  const [value, setValue] = useState<string|null>(defaultValue);

  const isValid = (input: string | null) => (
    !isEmpty(input)
  )

  return (
    <form id="recipe-search-form" key="recipe-search-form" style={{flexDirection: 'row'}}>
      <fieldset>
        <input
            placeholder="Type one or more ingredients..."
            type="text"
            id="q"
            value={value || undefined}
            onChange={(e) => setValue(e.target.value)}
            name="q"
        />
      </fieldset>

      <button disabled={!isValid(value)} className="button" type="submit">
        Search
      </button>
    </form>
  );
}
