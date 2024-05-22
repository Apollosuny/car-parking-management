module.exports = {
  content: [
    "./app/views/**/*",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.{js, jsx, vue}",
  ],
  theme: {
    extend: {},
  },
  plugins: [
    require("@tailwindcss/forms"),
    require("@tailwindcss/typography"),
    require("@tailwindcss/aspect-ratio"),
    require("@tailwindcss/line-clamp"),
  ],
};
