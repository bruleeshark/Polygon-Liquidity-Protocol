const express = require("express");
const path = require("path");
const app = express();

// Serve static files from the 'public' directory
app.use(express.static(path.join(__dirname, "public")));

// Set the port number
const port = process.env.PORT || 8080;

// Start the server
app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
