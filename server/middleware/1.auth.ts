export default defineEventHandler((event) => {
  event.context.user = { name: "Nitro" };
});
