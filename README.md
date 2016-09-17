# README

Сервис единой регистрации GravaClone. Для доступа сторонних сервисов реализован oauth2.

## Как запустить?

Честно говоря, не понял каким образом нужно создать контейнер который сможет все развернуть с помощью одной команды `docker run`, по этому пошел по простому пути и использовал `docker-compose`

1. `docker-compose build .`

2. `docker-compose run web bundle install && bundle exec rake db:create && bundle exec rake db:migrate`

3. `docker-compose up`

После исполнения всех команд сервис будет доступен на 3000 порту.

## Как протестировать приложение?

1. После запуска приложения необходимо зарегестрироватся и создать клиентское приложени.

2. Создав клиентское приложение мы получили `application_id` и `secret`. Теперь мы можем протестировать API.

3. Для этого необходимо пройти аутентификацию по oauth2 протоколу. Нужно на странице вашего приложения нажать `authorize` и получить код аутентификаци.

4. Теперь необходимо получить `access_token` для того что бы иметь возможность делать запросы к api.
```
curl -F grant_type=authorization_code \
     -F client_id=9b36d8c0db59eff5038aea7a417d73e69aea75b41aac771816d2ef1b3109cc2f \
     -F client_secret=d6ea27703957b69939b8104ed4524595e210cd2e79af587744a7eb6e58f5b3d2 \
     -F code=fd0847dbb559752d932dd3c1ac34ff98d27b11fe2fea5a864f44740cd7919ad0 \
     -F redirect_uri=urn:ietf:wg:oauth:2.0:oob \
     -X POST http://localhost:3000/oauth/token
```

5. Сделав запрос на `/api/v1/users/me` мы получим данные о самом себе.

## Описание API

### /api/v1/users/me

##### request

headers: { Authorization: Bearer `current_user_access_token` }

method: GET

url: /api/v1/users/me

##### response

`{
  "user": {
    "first_name": "Fill",
    "last_name": "Bill",
    "full_name": "Fill Bill",
    "email": "admin@example.com"
  }
}
`

### /api/v1/users/:email

:email - is a urlsafe base64 encoded string

##### request

headers: { Authorization: Bearer `current_user_access_token` }

method: GET

url: /api/v1/users/YWRtaW5AZXhhbXBsZS5jb20=

##### response

`{
  "user": {
    "first_name": "Fill",
    "last_name": "Bill",
    "full_name": "Fill Bill",
    "email": "admin@example.com"
  }
}
`

## Система отправления изминений

При каждом запросе к пользователям приложение создает отнашение между клиентским приложением в базе данных и пользователем.
В случаи когда пользователь изменяет свои данные и при создании клиентского приложения был указан `user_update_url`, приложение ему отправит запрос с jsonом типа:

`{ "email": "admin@example.com", "changed": { "first_name": ["Fill", "Bill"] } }`
