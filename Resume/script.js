updateVisitCount();
function updateVisitCount() {
  fetch(
    "https://oi81ficcig.execute-api.me-central-1.amazonaws.com/prod"
    //https://l4sap454r7.execute-api.me-central-1.amazonaws.com/prod/visitor-counter api of previous (point and click, not terraform) resources.
  )
    .then((response) => {
      return response.json();
    })
    .then((data) => {
      console.log(data);
      document.getElementById("counter-text").innerHTML =
        "You are visitor number: ";
      document.getElementById("counter").innerHTML = data;
    });
}
