window.addEventListener("DOMContentLoaded", domLoaded);

// When the DOM has finished loading, add the event listeners.
function domLoaded() {
   // TODO: Use addEventListener() to register a click event handler for the convert button.
   // https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener#add_a_simple_listener
   //.addEventListener is what will add a listener to function
   // Add event listeners to handle clearing the
   // box that WAS NOT clicked,
   // e.g., the element C_in listens for 'input', with a callback fn to
   // execute after that event does happen. 
   // You don't send arguments to the event handler function.
   // So, if you want the event handler to call another function that
   // DOES take arguments, you can send that other function as a callback.
   // https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener#event_listener_with_anonymous_function
   // Here is an example of anonymous event handler fn that calls alert with an argument:
   // document.getElementById("weatherIcon").addEventListener("click", function() {alert("You clicked the icon.")})

   const convertButton = document.getElementById("convertButton");
   const fInput = document.getElementById("F_in");
   const cInput = document.getElementById("C_in");

   convertButton.addEventListener("click", function () { 
      handleConvert(fInput, cInput);
   });

   fInput.addEventListener("input", function () {
      if (fInput.value !== "") {
         cInput.value = "";
      }
   });

   cInput.addEventListener("input", function () {
      if (cInput.value !== "") {
         fInput.value = "";
      }
   });
}
// TODO: (Part of the above is to write the functions to be executed when the event handlers are invoked.)
function handleConvert(fInput, cInput) {
   const message = document.getElementById("message");
   const weatherIcon = document.getElementById("weatherIcon");

   message.textContent = ""; // clear any previous message
   let fVal = fInput.value;
   let cVal = cInput.value;

   if (fVal === "" && cVal === "") {
      // no input
      message.textContent = "Enter a temperature to convert";
      weatherIcon.src = "images/C-F.png";
      return;
   }

   if (cVal !== "") {
      let c = parseFloat(cVal);
      let f = convertCtoF(c);
      fInput.value = f.toFixed(2);
      updateImage(f);
   } else if (fVal !== "") {
      let f = parseFloat(fVal);
      let c = convertFtoC(f);
      cInput.value = c.toFixed(2);
      updateImage(f);
   }
}

function convertCtoF(C) {
   // TODO: Return temp in °F. 
   // °F = °C * 9/5 + 32
   return C * 9 / 5 + 32;
}

function convertFtoC(F) {
   // TODO: Return temp in °C. 
   // °C = (°F - 32) * 5/9
   return (F - 32) * 5 / 9;
}

// TODO: write a fn that can be called with every temp conversion
// to display the correct weather icon.
// Based on degrees Fahrenheit:
// 32 or less, but above -200: cold
// 90 or more, but below 200: hot
// between hot and cold: cool
// 200 or more, -200 or less: dead
// both input fields are blank: C-F
function updateImage(fahrenheit) {
   const weatherIcon = document.getElementById("weatherIcon");

   if (fahrenheit > -200 && fahrenheit <= 32) {
      weatherIcon.src = "images/cold.png";
   } else if (fahrenheit >= 90 && fahrenheit < 200) {
      weatherIcon.src = "images/hot.png";
   } else if (fahrenheit > 32 && fahrenheit < 90) {
      weatherIcon.src = "images/cool.png";
   } else {
      weatherIcon.src = "images/dead.png";
   }
}