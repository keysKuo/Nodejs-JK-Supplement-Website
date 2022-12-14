const express = require("express");
const handlebars = require("express-handlebars");
const port = process.env.PORT || 3000;
const app = express();
const path = require("path");
require("dotenv").config();
const db = require("./config/db");
const session = require("express-session");
const flash = require("express-flash");
const cookieParser = require("cookie-parser");
const bodyParser = require("body-parser");
const router = require("./resources/routes");

app.set("view engine", "hbs");
app.engine(
  "hbs",
  handlebars.engine({
    extname: "hbs",
    helpers: {
      select: function (selected, options) {
        return options
          .fn(this)
          .replace(
            new RegExp(' value="' + selected + '"'),
            '$& selected="selected"'
          );
      },
      toPrice: function (price) {
        if (Number(price) == 0) return "Theo thời giá";
        return Number(price).toLocaleString("vi", {
          style: "currency",
          currency: "VND",
        });
      },
    },
  })
);
app.set("views", path.join(__dirname, "resources/views"));
app.use(express.static(path.join(__dirname, "public")));

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(cookieParser("sud"));
app.use(session({ cookie: { maxAge: 3000000 } }));
app.use(flash());
app.use(bodyParser.urlencoded({ extended: false }));

router(app);

app.get('/', async (req, res, next) => {
	let hotProducts = await db.Query('Select TOP 4 * From Product Order by nImport - nExport')
		.then(products => {
			return products.map(p => {
				let stock = p.nImport - p.nExport;
				return {
					pid: p.pid,
					pname: p.pname,
					price: p.price,
					image: p.image,
					stock: (stock > 0) ? `Còn hàng: ${stock}` : 'Hết hàng',
					slug: p.slug
				}
			})
		})
		.catch(err => {
			return res.json({success: false, msg: 'Database not found'});
		})

    let newProducts = await db.Query('Select TOP 4 * From Product Order by createdAt desc')
		.then(products => {
			return products.map(p => {
				let stock = p.nImport - p.nExport;
				return {
					pid: p.pid,
					pname: p.pname,
					price: p.price,
					image: p.image,
					stock: (stock > 0) ? `Còn hàng: ${stock}` : 'Hết hàng',
					slug: p.slug
				}
			})
		})
		.catch(err => {
			return res.json({success: false, msg: 'Database not found'});
		})
	
	let veganProducts = await db.Query(`Select TOP 4 * From Product Where cid = 'VP' Order by createdAt desc`)
		.then(products => {
			return products.map(p => {
				let stock = p.nImport - p.nExport;
				return {
					pid: p.pid,
					pname: p.pname,
					price: p.price,
					image: p.image,
					stock: (stock > 0) ? `Còn hàng: ${stock}` : 'Hết hàng',
					slug: p.slug
				}
			})
		})
		.catch(err => {
			return res.json({success: false, msg: 'Database not found'});
		})

		return res.render('others/home', {
			hotProducts: hotProducts,
			newProducts: newProducts,
			veganProducts: veganProducts,
			hideFooter: true
		})
})

app.get("/contact", (req, res) => {
	console.log(__dirname);
	res.render("others/contact");
  });
  
  app.get("/support", (req, res) => {
	res.render("others/support");
  });

app.get("/shopping-cart", (req, res) => {
	const error = req.flash("error") || "";
	const success = req.flash("success") || "";
	let list = req.flash("list") || "";
	let listProduct = [];
	//   list = JSON.parse(list);
	//   list.forEach((item) => {
	//     item = JSON.parse(item);
	//     listProduct.push(item);
	//   });
	res.render("others/shoppingCart", { error, success, list });
});

app.listen(port, () => console.log("Server running on port: " + port));
