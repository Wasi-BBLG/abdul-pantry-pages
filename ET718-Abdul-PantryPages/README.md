# Pantry Pages — ET-718 Ruby on Rails Blog

Personal starter for **Abdul**. Theme: A practical kitchen journal for small experiments and favorite meals.

## Unique functionality

Recipe cards with ingredient lists, prep times, difficulty ratings, meal filters, and a 30-minute toggle. This design and these fields differ from the earlier Devlog, Afterglow, and Sideline student starters, and from the other projects in this batch.

## Shared ET-718 blog requirements

- Rails 7.2, Ruby 3.2+, SQLite
- Create, view, edit, and delete posts
- Required fields and server-side validation
- Article comments, linked to their parent post
- Basic authentication for editors (publishing, editing, deleting)
- Responsive design, sample entries, and Cloud9 preview configuration

## Put the project on GitHub

1. Extract this ZIP file.
2. Create a new, empty repository in **your own GitHub account**.
3. Open the extracted `ET718-Abdul-PantryPages` folder, upload its **contents** to GitHub (not the ZIP itself).
4. Commit the files. The `rails-source/` folder is a source overlay; it will not run until Cloud9 generates the standard Rails files.

## Set up in AWS Cloud9

Open Cloud9's terminal. Replace the placeholder URL and folder with your repository information:

```bash
cd ~/environment
git clone https://github.com/YOUR-USERNAME/YOUR-REPOSITORY.git
cd YOUR-REPOSITORY
bash setup-cloud9.sh
bash start-cloud9.sh
```

The setup script installs Rails 7.2.4 if missing, generates `blog/`, copies the `Pantry Pages` code into it, installs gems, prepares and seeds the SQLite database, and adds development-only Cloud9 preview fixes.

**Leave the Rails server terminal open.** Use **Preview → Preview Running Application** in Cloud9; the site listens on port **8080**.

For local editor access, open a *second* terminal at the repository root and run:

```bash
cat .local-admin.env
```

Editor username: `admin`. A unique password is generated in `.local-admin.env`. **Do not commit that file, the Rails master key, or any local database files to GitHub.**

## After it works: upload the generated app

In a second Cloud9 terminal, from the repository root:

```bash
git status
git add .
git commit -m "Finish ET-718 Rails blog"
git push origin main
```

The `.gitignore` excludes the local SQLite database, runtime cache, and secrets. Review `git status` before committing.

## If something goes wrong

- `rails: command not found`: run `gem install rails -v 7.2.4 --no-document` then rerun the setup script.
- `bootsnap/setup`: run `cd blog && bundle install` and restart the server.
- `Blocked hosts`: the setup script allows Cloud9 preview hostnames in `development.rb`.
- `refused to connect`: leave the server running and use `curl -I http://127.0.0.1:8080/` in another terminal to check localhost.
- On re-running setup, an existing `blog/` Rails folder is preserved (not overwritten).

## Submit your own work

The included entries are examples. Replace them with your own writing, test all CRUD actions and comments, and confirm the professor's precise rubric. This is a project starter, not a finished or graded midterm submission.
