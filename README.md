### [Трекер пользователей с web интерфейсом](https://github.com/zhekbland/heroku_tracker/tree/master/src/main)
### [Трекер пользователей на Heroku](https://zhekbland-servlets.herokuapp.com/)
### [Tracker on AWS](http://servlet-tracker.eu-central-1.elasticbeanstalk.com/)

Для тестирования:
Login: admin Password: root

В веб приложениии реализована авторизация пользователей по ролям. Администратор может редактировать всех пользователей,
выполнять CRUD операции.
Обычный пользователь может только редактировать свои данные.

Во время создания пользователя введеные данные (login, email) сверяются с БД через AJAX с использованием JQuery и JSON.
Запрос не будет отправлен если есть дублирующиеся данные, пароль менее 7 символов, незаполненые поля.
Обновление выполняется аналогично с загрузкой актуальных данных пользователя. Только администратор может менять роль.
Данные динамически прогружаются с помощью AJAX (Jquery, JSON, Jackson).
Интерфейс реализован при помощи библиотеки Bootstrap.
Используется БД MySQL на удаленном сервере.

Скриншоты приложения:

<img src='https://github.com/Zhekbland/job4j/blob/master/pic/servlet/servlet1.png'>

###
<img src='https://github.com/Zhekbland/job4j/blob/master/pic/servlet/servlet2.png'>

###
<img src='https://github.com/Zhekbland/job4j/blob/master/pic/servlet/servlet3.png'>

###
<img src='https://github.com/Zhekbland/job4j/blob/master/pic/servlet/servlet4.png'>

###
<img src='https://github.com/Zhekbland/job4j/blob/master/pic/servlet/servlet5.png'>

В приложении были использованы следующие технологии и библиотеки:

* MVC
* JDBC
* Log4j2
* MySQL
* PostgreSQL
* Servlet
* JSP JSTL
* JavaScript
* JQuery
* AJAX
* Jackson (JSON parsing)
* Bootstrap