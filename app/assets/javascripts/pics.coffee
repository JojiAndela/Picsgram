jQuery ->
  $('[data-behavior="autocomplete"]').atwho(
    at: "@",
    'data': "/share/users.json",
    'insertTpl': "@${username}",
    'displayTpl': "<li data-id ='${id}'><span>${username}</span></li> "
    )
