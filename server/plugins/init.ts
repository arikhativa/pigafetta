export default defineNitroPlugin(async (nitroApp) => {
  consola.start("Validating environment variables...");
  validateEnvUnsafe();
  consola.info("Environment variables are ok :)");

  consola.success("Server is up and running!");
  consola.box("Pigafetta Let's Goooo");
});
