const undergrad = document.getElementById('essay_applicant_type_undergraduate')
const grad = document.getElementById('essay_applicant_type_graduate')
const wordCount = document.getElementById('essay_word_count')
const dynamicPrice = document.querySelector('.price')

let price
if (undergrad.checked == false && grad.checked == false) {
  price = 0
} else if (undergrad.checked === true) {
  if (wordCount.value == "") {
    price = 0
  } else if (parseInt(wordCount.value) <= 250) {
    price = 80
  } else if (parseInt(wordCount.value) <= 400) {
    price = 110
  } else if (parseInt(wordCount.value) <= 600) {
    price = 130
  } else if (parseInt(wordCount.value) > 600) {
    price = 180
  }
} else if (grad.checked === true) {
  if (wordCount.value == "") {
    price = 0
  } else if (parseInt(wordCount.value) <= 250) {
    price = 90
  } else if (parseInt(wordCount.value) <= 400) {
    price = 120
  } else if (parseInt(wordCount.value) <= 600) {
    price = 150
  } else if (parseInt(wordCount.value) > 600) {
    price = 200
  }
} else price = 0
dynamicPrice.innerText = price

wordCount.addEventListener("keyup", (e) => {
  let price
  if (undergrad.checked == false && grad.checked == false) {
    price = 0
  } else if (undergrad.checked === true) {
    if (wordCount.value == "") {
      price = 0
    } else if (parseInt(wordCount.value) <= 250) {
      price = 80
    } else if (parseInt(wordCount.value) <= 400) {
      price = 110
    } else if (parseInt(wordCount.value) <= 600) {
      price = 130
    } else if (parseInt(wordCount.value) > 600) {
      price = 180
    }
  } else if (grad.checked === true) {
    if (wordCount.value == "") {
      price = 0
    } else if (parseInt(wordCount.value) <= 250) {
      price = 90
    } else if (parseInt(wordCount.value) <= 400) {
      price = 120
    } else if (parseInt(wordCount.value) <= 600) {
      price = 150
    } else if (parseInt(wordCount.value) > 600) {
      price = 200
    }
  }
  dynamicPrice.innerText = price
})

undergrad.addEventListener("change", (e) => {
  let price
    if (wordCount.value == "") {
      price = 0
    } else if (parseInt(wordCount.value) <= 250) {
      price = 80
    } else if (parseInt(wordCount.value) <= 400) {
      price = 110
    } else if (parseInt(wordCount.value) <= 600) {
      price = 130
    } else if (parseInt(wordCount.value) > 600) {
      price = 180
    }
  dynamicPrice.innerText = price
})

grad.addEventListener("change", (e) => {
  let price
    if (wordCount.value == "") {
      price = 0
    } else if (parseInt(wordCount.value) <= 250) {
      price = 90
    } else if (parseInt(wordCount.value) <= 400) {
      price = 120
    } else if (parseInt(wordCount.value) <= 600) {
      price = 150
    } else if (parseInt(wordCount.value) > 600) {
      price = 200
    }
  dynamicPrice.innerText = price
})
