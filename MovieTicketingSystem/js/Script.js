const container = document.querySelector(".seat-container");
const seats = document.querySelectorAll(".seat-row .seat:not(.sold)");
const seatNum = document.getElementsByClassName("seatNum");
const count = document.getElementsByClassName("count");

populateUI();


// Update total and count
function updateSelectedCount() {
    let text = "";
    const selectedSeats = document.querySelectorAll(".seat-row .seat.selected");

    const seatsIndex = [...selectedSeats].map((seat) => [...seats].indexOf(seat));

    localStorage.setItem("selectedSeats", JSON.stringify(seatsIndex));

    selectedSeats.forEach(getText);
    function getText(item, index) {
        text += item.innerText + " ";
    }

    const selectedSeatsCount = selectedSeats.length;
    document.cookie = "seatNum=" + text;
    document.cookie = "ticket=" + selectedSeatsCount;
}



// Get data from localstorage and populate UI
function populateUI() {
    const selectedSeats = JSON.parse(localStorage.getItem("selectedSeats"));

    if (selectedSeats !== null && selectedSeats.length > 0) {
        seats.forEach((seat, index) => {
            if (selectedSeats.indexOf(index) > -1) {
                console.log(seat.classList.add("selected"));
            }
        });
    }

}
console.log(populateUI())

container.addEventListener("click", (e) => {
    if (
        e.target.classList.contains("seat") &&
        !e.target.classList.contains("sold")
    ) {
        e.target.classList.toggle("selected");

        updateSelectedCount();
    }
});



// Initial count and total set
updateSelectedCount();