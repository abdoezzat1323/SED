import { NavLink } from "react-router-dom";

export default function SellSlider({ sell }) {
  return (
    <NavLink to={`/items/${sell._id}`} className="text-decoration-none ">
      <div className="item slider-style2 mb-1">
        <div className="slider-service-div  text-center  ">
          <div className="slider-service-img ">
            <img
              src={sell.productImage}
              className="card-img-top w-100 h-100  "
              alt="..."
            />
          </div>

          <div className="slider-service-title">
            <h5 className="card-title text-black mb-3 mt-3">
              {sell.productName}
            </h5>
          </div>
          <div className="slider-service-detailes ">
            <p className=" text-black  h-100 w-100 "></p>
          </div>
          <div className="slider-service-price ">
            <p className=" text-black mb-3 h-100 w-100">{sell.price}</p>
          </div>

          <div className="slider-service-btn">
            <button className="btn btn-primary mt-2 mb-3">
              <NavLink to={"n"} className="text-decoration-none text-white">
                Show More
              </NavLink>
            </button>
          </div>
        </div>
      </div>
    </NavLink>
  );
}
