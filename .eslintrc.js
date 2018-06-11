const path = require("path");

module.exports = {
  extends: "payfit",
  settings: {
    "import/resolver": {
      "eslint-import-resolver-lerna": {
        packages: path.resolve(__dirname, "packages")
      }
    }
  }
};
