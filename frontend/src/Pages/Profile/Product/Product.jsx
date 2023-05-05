import "./Product.css";
import React from "react";
import { Link } from "react-router-dom";
import { GiToggles } from "react-icons/gi";
import Axios from "axios";
import { useEffect, useState } from "react";
import Paginate from "../../../Component/pagination/Paginate";

export default function Product() {
  const UserToken = localStorage.getItem("usertoken");
  console.log(UserToken);
  let [UserID, setUserID] = useState("");
  let [UserData, setUserData] = useState([]);
  const [totalpageNum, settotalpageNum] = useState(1);
  const [currentpageNum, setcurrentpageNum] = useState(1);
  const paginate = (pageNumber) => setcurrentpageNum(pageNumber);
  const [isPending, setIsPending] = useState(false);
  const [error, setError] = useState(null);
  console.log(UserData);
  const UserProduct = async () => {
    setError(null);
    setIsPending(true);

    try {
      let UserData = await Axios.get(
        `http://103.48.193.225:3000/products/seller/${UserID}`,
        {
          headers: {
            Authentication: `Bearer ${UserToken}`,
          },
        }
      );
      setUserData(UserData.data.products);
      setIsPending(false);
    } catch (err) {
      setIsPending(false);
      setError("could not fetch the data");
      console.log(err.message);
    }
  };
  useEffect(() => {
    UserProduct();
    const storedUserData = window.localStorage.getItem("UserData");
    const parsedUserData = JSON.parse(storedUserData);
    setUserID(parsedUserData._id);
  }, [UserID, UserToken]);
  return (
    <>
      <div className="container-fluid  bg-dark  Productpage  ">
        <div className=" row  vh-100    ">
          <div id="style-7" className="  col-12  scrollbar   h-100 pt-4 ps-4 ">
            <div className="row  w-100 h-100 align-items-center justify-content-center ">
              <div className="col-xxl-9 col-xl-9 col-lg-9 col-md-9 col-sm-12 w-100 ">
                <div className="row justify-content-center">
                  {UserData.map((categ, index) => (
                    <div className="col-xxl-4  col-xl-4  col-lg-6 col-sm-6 col-6  ">
                      <Link
                        key={index}
                        to={`/Profile/settings/myadds/${categ._id}`}
                        className="text-decoration-none "
                      >
                        <div className="item slider-style2 mb-3 ">
                          <div className="slider-service-div  text-center seeAll_bg_item w-100 ">
                            <div className="slider-service-img ">
                              <img
                                src={categ.productImage}
                                className="card-img-top w-100 h-100  "
                                alt="..."
                              />
                            </div>

                            <div className="slider-service-title">
                              <h5 className="card-title text-black mb-3 mt-3">
                                {categ.productName}
                              </h5>
                            </div>
                            <div className="slider-service-detailes ">
                              <p className=" text-black  h-100 w-100 ">
                                Some quick example text to build on the card
                                title and make up the bulk of the card's content
                              </p>
                            </div>
                            <div className="slider-service-price ">
                              <p className=" text-black mb-3 h-100 w-100">
                                {categ.price}
                              </p>
                            </div>

                            <div className="slider-service-btn">
                              <button className="btn btn-primary mt-2 mb-3">
                                <Link
                                  to={"n"}
                                  className="text-decoration-none text-white"
                                >
                                  ADD TO CARD
                                </Link>
                              </button>
                            </div>
                          </div>
                        </div>
                      </Link>
                    </div>
                  ))}
                </div>
              </div>
              <div className=" d-flex justify-content-center pb-5 ">
                <Paginate paginate={paginate} totalpageNum={totalpageNum} />
              </div>
            </div>
          </div>
        </div>
      </div>
    </>
  );
}