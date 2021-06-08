
# Proof and Consequences

Scaffolding adapted from: https://github.com/EdNutting/github-pages-agda

# Participating
## Getting started
You should be able to follow the [plfa getting started section for Emacs](https://plfa.github.io/GettingStarted/) and then

```bash
git clone https://github.com/o1lo01ol1o/proof-and-consequences.git
cd proof-and-consequences && emacs .
```

You can check that `agda-mode` is functioning by opening `src/Foo.agda` and then loading the module into `agda-mode`.  Agda will then expose a "hole" for the definition of doublenegation and you can begin interative thoerm proving.

Once the above works, you can enable literate programming support for `md` files by adding the following to your `~/.emacs.d/init.el` file:

``` emacs-lisp
(add-to-list 'auto-mode-alist '("\\.lagda.md\\'" . agda2-mode))
```

This will let you turn code into pretty `html` with `pandoc`:

``` bash
agda --html --html-highlight=code blogpost.lagda.md
pandoc html/blogpost.md -o blogpost.html
```

See [here](https://jesper.sikanda.be/posts/literate-agda.html)
