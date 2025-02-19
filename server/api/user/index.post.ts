export default defineEventHandler(async (event) => {
  const body = await readBody(event);

  console.log("body", body);
  // Do something with body like saving it to a database

  return null;
});
