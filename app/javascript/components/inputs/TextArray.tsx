import { startCase, times } from "lodash";
import React from "react";
import useParams from "../hooks/useParams";

/**
 * 
 * @param param0 
 * @returns 
 */
export default function TextArrayInput({
  name,
  label,
  placeholder,
  cardinality,
}: {
  name: string;
  label: string;
  placeholder: string;
  cardinality: number;
}) {
  const params = useParams();
  const defaultValues: string[] = params.getAll(`${name}[]`);

  return (
    <fieldset key={name}>
      <label htmlFor={name}>{label}</label>
      {times(cardinality, (i: number) => {
        return (
          <input
            key={`${name}-${i}`}
            placeholder={placeholder}
            type="text"
            id={`${name}-${i}`}
            defaultValue={defaultValues[i]}
            name={`${name}[]`}
          />
        );
      })}
    </fieldset>
  );
}
