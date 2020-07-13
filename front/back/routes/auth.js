const router = require("express").Router();
const User = require("../model/user_model");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
//VALIDATION
const { registerValidation, loginValidation } = require("../validation");

//registration
router.post("/register", async (req, res) => {
  const { error } = registerValidation(req.body);
  if (error) {
    return res.status(400).send(error.details[0].message);
  }
  const userFromBody = {
    name: req.body.name,
    email: req.body.email,
    filiale: req.body.filiale,
    password: req.body.password
  };
  const emailExist = await User.findOne({ email: userFromBody.email });
  if (emailExist) return res.status(400).send("email already exists!");
  const filialeExist = await User.findOne({ filiale: userFromBody.filiale });
  if (filialeExist)
    return res
      .status(400)
      .send(`Le filiale ${userFromBody.filiale} est déja inscrit!`);
  //Hash Password

  const salt = await bcrypt.genSalt(10);
  const hashPassword = await bcrypt.hash(userFromBody.password, salt);
  userFromBody.password = hashPassword;
  const user = new User(userFromBody);
  user
    .save()
    .then(user => {
      console.log(user.schema);
      return res.status(200).send(user._id);
    })
    .catch(err => {
      console.log(err);
      res.status(400).send(err);
    });
});
//LOGIN
router.post("/login", async (req, res) => {
  const enteredInfos = {
    email: req.body.email,
    password: req.body.password
  };
  const { error } = loginValidation(enteredInfos);
  if (error) return res.status(400).send(error.details[0].message);
  const user = await User.findOne({ email: enteredInfos.email });
  if (!user) return res.status(400).send("No User With this Email Exists!");
  const validPassword = await bcrypt.compare(
    enteredInfos.password,
    user.password
  );
  if (!validPassword) return res.status(400).send("Invalid Password");
  const token = jwt.sign({ _id: user._id }, process.env.TOKEN_SECRET);
  res.header("auth-token", token).send(token);
});
module.exports = router;
