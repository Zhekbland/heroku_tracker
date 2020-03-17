<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Create</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
            integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
            crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
            integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
            crossorigin="anonymous"></script>
    <style>
        body {
            font-family: 'Roboto', -apple-system, system-ui, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
        }
    </style>
    <script>
        /**
         * This is GET request via AJAX (JSON)
         */
        function getCountries() {
            $.ajax({
                url: '${pageContext.servletContext.contextPath}/country',
                method: 'get',
                contentType: 'text/json',
                complete: function (data) {
                    let countries = JSON.parse(data.responseText);
                    for (let value of countries) {
                        $('#country').append('<option value="' + value + '">' + value + '</option>');
                    }
                }
            });
        }

        /**
         * This is POST (with parameters (data)) request via AJAX (JSON)
         */
        function getCities() {
            $.ajax({
                url: '${pageContext.servletContext.contextPath}/city',
                method: 'post',
                dataType: 'json',
                data: JSON.stringify($('#country option:selected').val()),
                complete: function (data) {
                    updateSelect();
                    let cities = JSON.parse(data.responseText);
                    for (let city of cities) {
                        $('#city').append('<option value="' + city + '">' + city + '</option>');
                    }
                }
            });
        }

        function updateSelect() {
            $('#city').empty();
            $('#city').removeAttr('disabled');
        }

        /**
         * This forms validation.
         */
        function validate() {
            var result = true;
            for (let input of $(".form-control")) {
                if (input.value == '') {
                    alert("Fill " + input.getAttribute('name') + " form!");
                    result = false;
                }
            }
            return result;
        }

        function postData() {
            if (validate()) {
                let user = $('.form-control');
                $.ajax({
                    url: '${pageContext.servletContext.contextPath}/create',
                    method: 'POST',
                    dataType: 'JSON',
                    data: JSON.stringify({
                        name: user[0].value,
                        login: user[1].value,
                        email: user[2].value,
                        password: user[3].value,
                        role: user[4].value,
                        country: user[5].value,
                        city: user[6].value,
                    }),
                    complete: function () {
                        window.location.href = '${pageContext.servletContext.contextPath}/users';
                    }
                });
            }
        }

        function valueChecker(inputForCheck) {
            let inputValue = $('#' + inputForCheck);
            if (inputValue.val() == '') {
                inputValue.removeClass('is-valid');
                inputValue.addClass('is-invalid');
            } else {
                inputValue.removeClass('is-invalid');
                inputValue.addClass('is-valid');
            }
        }

        function valueDBChecker(inputForCheck, valueExists) {
            let inputValue = $('#' + inputForCheck);
            if (inputValue.val() == '' || valueExists) {
                inputValue.removeClass('is-valid');
                inputValue.addClass('is-invalid');
            } else {
                inputValue.removeClass('is-invalid');
                inputValue.addClass('is-valid');
            }
        }

        function loginExistsChecker(inputForCheck) {
            let userLogin = $('#login_input').val();
            let userId = 0;
            $.ajax({
                url: '${pageContext.servletContext.contextPath}/loginexists',
                method: 'post',
                dataType: 'json',
                data: JSON.stringify({'userId' : userId, 'userLogin' : userLogin}),
                complete: function (data) {
                    // updateSelect();
                    let loginExist = JSON.parse(data.responseText);
                    console.log(loginExist);
                    valueDBChecker(inputForCheck, loginExist);
                }
            });
        }

        function emailExistsChecker(inputForCheck) {
            let userEmail = $('#email_input').val();
            let userId = 0;
            $.ajax({
                url: '${pageContext.servletContext.contextPath}/emailexists',
                method: 'post',
                dataType: 'json',
                data: JSON.stringify({'userId' : userId, 'userEmail' : userEmail}),
                complete: function (data) {
                    // updateSelect();
                    let emailExists = JSON.parse(data.responseText);
                    console.log(emailExists);
                    valueDBChecker(inputForCheck, emailExists);
                }
            });
        }

        function passwordChecker(inputForCheck) {
            let inputValue = $('#' + inputForCheck);
            console.log(inputValue.val().length);
            if (inputValue.val() == '' || inputValue.val().length < 8) {
                inputValue.removeClass('is-valid');
                inputValue.addClass('is-invalid');
            } else {
                inputValue.removeClass('is-invalid');
                inputValue.addClass('is-valid');
            }
        }
    </script>
</head>
<body>
<div class="container">
    <div class="row my-4">
        <div class="col-3">
            <form action="${pageContext.servletContext.contextPath}/create" method="post">

                <div id="name-group" class="form-group">
                    <label for="name_input">First name</label>
                    <input type="text" class="form-control" id="name_input" required
                           name="name" placeholder="Enter name" onblur="valueChecker('name_input')">
                    <div class="invalid-feedback">
                        Enter name!
                    </div>
                    <div class="valid-feedback">
                        Confirm!
                    </div>
                </div>

                <div class="form-group">
                    <label for="login_input">Login</label>
                    <input id="login_input" type="text" class="form-control" name="login"
                           placeholder="Enter login" onblur="loginExistsChecker('login_input')">
                    <div class="invalid-feedback">
                        Enter login, this login is taken!
                    </div>
                    <div class="valid-feedback">
                        Confirm!
                    </div>
                </div>

                <div class="form-group">
                    <label for="email_input">Email</label>
                    <input id="email_input" type="text" class="form-control" name="email"
                           placeholder="Enter email" onblur="emailExistsChecker('email_input')">
                    <div class="invalid-feedback">
                        Enter email, this email is taken!
                    </div>
                    <div class="valid-feedback">
                        Confirm!
                    </div>
                </div>


                <div class="form-group">
                    <label for="password_input">Passowrd</label>
                    <input id="password_input" type="password" class="form-control" name="password"
                           placeholder="Enter password" onblur="passwordChecker('password_input')">
                    <div class="invalid-feedback">
                        Enter password greater than 7 symbols!
                    </div>
                    <div class="valid-feedback">
                        Confirm!
                    </div>
                </div>
                <div class="form-group my-3">
                    <label>Role</label>
                    <select class="form-control" name="role">
                        <option value="ADMIN">Administrator</option>
                        <option value="USER" selected>User</option>
                    </select>
                </div>
                <div class="form-group my-3">
                    <label>Country</label>
                    <select class="form-control form-select" name="country" id="country" onchange="return getCities()">
                        <script>getCountries()</script>
                        <option value="">select country...</option>
                    </select>
                </div>
                <div class="form-group my-3">
                    <label>City</label>
                    <select disabled class="form-control form-select" name="city" id="city">
                        <option value="">select city...</option>
                    </select>
                </div>

                <div class="my-5">
                    <button type="button" class="btn btn-secondary" onclick="return postData()">Create</button>
                </div>
            </form>
        </div>
        <div class="col-9 d-flex justify-content-end mt-4">
            <form action="${pageContext.servletContext.contextPath}/signout" method="post">
                <button type="submit" class="btn btn-secondary">SignOut</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>