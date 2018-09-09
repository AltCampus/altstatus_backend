# AltStatus

## What is AltStatus?

When you are learning new skills, it's beneficial to track your learning process. At [AltCampus](https://altcampus.io/) students are required to do a bunch of things to keep track their progress. They have to tweet daily about what did they learn that day and write a blog post once a week. Beside tweets and blog, students will also write a reflection of that particular day. AltStatus helps them to organize and track their progress.

A Student can submit their tweet URL, blog-post URL every Saturday and reflection of the day. By this way, they can track of their progress. They will get a notification at a specific time of the day, asking them about whether they had submited the links or not.

## Student flow

There will be two screens in the app.
- Screen-1 (Login/Signup page)
- Screen-2 (Student Dashboard)

### Screen-1

If student has already signup then he will see login page otherwise student have to signup on the app.

### Screen-2
After signing in to the app, the student will see the dashboard. Now the dashboard screen will be divided into two parts. First part will be the *submission form* and second part will be the *list of previous submissions*.

Now here is a condition on the first part, if student have already submited the form then he will see his today's submission, otherwise he will see the submission form.

**Submission Form** will be different on Saturday. Because on Saturday, the students will have to submit their blog-post link. On other days they have to submit just their tweet URL and reflection of the day.

## Back-end Setup

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
