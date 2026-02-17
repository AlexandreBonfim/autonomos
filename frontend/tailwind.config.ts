import type { Config } from "tailwindcss";

export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  theme: {
    extend: {
      colors: {
        primary: "#60d38d",
        surface: "#f7f7f7",
        background: "#ffffff",
        text: "#000000",
      },
      borderRadius: {
        xl: "16px",
      },
    },
  },
  plugins: [],
} satisfies Config;