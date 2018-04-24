## Introduction
Contributions are always welcome. Also, if you have any confusion,
please feel free to create an issue.


### Key information

* The documentation source files are inside `content/` directory.
* The source files are written in `Markdown`.
* The HTML documentation site is built using [mkdocs](http://www.mkdocs.org),
  a Python package to build documentation.


## How to contribute

### Fork it, clone it

Fork the [docs repo](https://github.com/khalti/khalti-docs-official-repo) by using the
Github interface.

Clone that fork into your development machine.

```bash
git clone git@github.com:<YOUR_USERNAME>/khalti-docs-official-repo.git
```

### Locally building and serving

Install `mkdocs` using any of the methods specified in the
[official documentation](http://www.mkdocs.org/#installation).

To serve the docs locally, run:

```bash
mkdocs serve
```

This will build and host the `.md` files in `http://localhost:8000`. It will also
live reload the page when you make changes in the source files.

### Pushing changes

Once you've made necessary changes, push it to your forked repository by running:

```bash
git push origin master
```

After you've done this, you need to ask us to merge your changes to the main repo.
Github provides pull request feature to accomplish that.

Go to the [pull requests](https://github.com/khalti/khalti-docs-official-repo/pulls)
tab of the main repo.

You'll notice a big green, **New pull request** button on the top right side of the
page. Click on that button and follow from there.
Your pull request will be reviewed and merged by one of Khalti development staff.
