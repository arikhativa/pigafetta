export default defineEventHandler(async () => {
  const data = await useStorage("assets:server").getItem(`secret.txt`);
  return data;
});
