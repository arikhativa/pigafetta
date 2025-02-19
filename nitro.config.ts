export default defineNitroConfig({
  experimental: {
    tasks: true,
  },
  plugins: ["plugins/init.ts"],
  srcDir: "server",
  compatibilityDate: "2025-02-22",
  imports: {
    imports: [
      {
        from: "consola",
        name: "consola",
      },
    ],
  },
});
