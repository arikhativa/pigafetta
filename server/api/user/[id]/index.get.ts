export default defineEventHandler((event) => {
  const id = getRouterParam(event, "id");

  if (id === "0") {
    throw createError({
      status: 404,
      statusMessage: "Bad :(",
      message: "User not found",
    });
  }
  return { id: id, time: new Date() };
});
