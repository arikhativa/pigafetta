export function validateEnvUnsafe() {
  // if (!process.env.DATABASE_URL) {
  //   throw new Error("DATABASE_URL is not set");
  // }
  // if (!process.env.DB_PASS) {
  //   throw new Error("DB_PASS is not set");
  // }
}

export function env() {
  const db = process.env.DATABASE_URL;
  if (!db) {
    throw new Error("DATABASE_URL is not set");
  }
  return {
    db,
  };
}
