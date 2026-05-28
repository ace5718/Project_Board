type ExampleComponentProps = {
  title: string;
};

export function ExampleComponent({ title }: ExampleComponentProps) {
  return <section>{title}</section>;
}
