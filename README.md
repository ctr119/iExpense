# Hola! 👋 👾 🎲 👨‍💻 

This project is about a simple and tiny app that lets you save your expenses :money_with_wings: letting you specify whether they are business related :briefcase: or personal :see_no_evil:

## Highlights

In this project you can find:
- A small example of the **Clean Architecture** stack
  - The `Display` stuct for each isolated `View`. Personally, I like to build each small view (like list rows, or reusable components) with their own data structure. That way, the component itself is well decoupled from whichever entity that makes use of it. You only need to know that it will work fine if you pass the data it expects.
- An amazing quirk from `ForEach`: the `onDelete` modifier (it does not work for `List`)
- One `List` with two sectinos inside
