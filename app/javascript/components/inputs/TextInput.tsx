import React, { useEffect, useState } from "react";

export default function TextInput({
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
}) {
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
      <a
        className="button danger"
        style={{ marginTop: 2 }}
        onClick={() => onClick()}
      >
        &#8212;
      </a>
    </div>
  );
}
