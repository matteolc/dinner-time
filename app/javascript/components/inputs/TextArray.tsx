import { pullAt, times } from "lodash";
import React, { useEffect, useState } from "react";
import useParams from "../hooks/useParams";

const TextInput = ({
  placeholder,
  defaultValue,
  id,
  name,
  onClick,
}: {
  placeholder: string;
  defaultValue: string;
  id: string;
  name: string;
  onClick: Function;
}) => {
  const [value, setValue] = useState<string>(defaultValue);

  useEffect(() => {
    setValue(defaultValue);
  }, [defaultValue]);

  return (
    <div
      style={{
        display: "flex",
        flexDirection: "row",
        justifyContent: "space-between",
        marginBottom: 12,
      }}
    >
      <input
        placeholder={placeholder}
        type="text"
        id={id}
        value={value}
        name={name}
        onChange={(e) => setValue(e.target.value)}
        style={{ marginRight: 6 }}
      />
      <a className="button danger" style={{marginTop: 2}} onClick={() => onClick()}>
        &#8212;
      </a>
    </div>
  );
};
/**
 *
 * @param param0
 * @returns
 */
export default function TextArrayInput({
  name,
  label,
  placeholder,
}: {
  name: string;
  label: string;
  placeholder: string;
}) {
  const params = useParams();
  let defaultValues: string[] | [] = params.getAll(`${name}[]`);
  const [inputs, setInputs] = useState<string[] | []>(defaultValues);

  return (
    <fieldset key={name}>
      <a className="button" style={{marginBottom: 12}} onClick={() => setInputs([...inputs, ""])}>
        Add an ingredient to search..
      </a>
      {times(inputs.length, (i: number) => (
        <TextInput
          placeholder={placeholder}
          defaultValue={inputs[i]}
          id={`${name}-${i}`}
          name={`${name}[]`}
          key={`${name}-${i}`}
          onClick={() => {
            pullAt(inputs, [i]);
            setInputs([...inputs]);
          }}
        />
      ))}
    </fieldset>
  );
}
