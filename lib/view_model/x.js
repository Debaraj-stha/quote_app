fetch("https://api.quotable.io/quotes?limit=150", {})
  .then((response) => response.json())
  .then((data) => console.log(data))
  .catch((error) => console.error(error));
