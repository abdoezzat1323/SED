import { Link, useParams } from "react-router-dom";
import { useEffect, useState } from "react";
import Navebar from "../../Component/navebar/navbar";
import "./dataitems.css";
import Footer from "../../Component/footer/Footer";
import { BiHeart } from "react-icons/bi";
import { FaHeart } from "react-icons/fa";
import { ToastContainer, toast } from "react-toastify";
import { UseAxiosGet } from "../../Component/axios/GetApi/GetApi";
import { UseAxiosPache } from "../../Component/axios/PachApi/PatchApi";
import { getTokendeta } from "../../Component/axios/tokendata/Token_Data";
import { UseAxiosPost } from "../../Component/axios/PostApi/PostApi";
export default function Dataitems() {
  const Tokendata = getTokendeta();
  const senderId = Tokendata ? Tokendata.id : "";
  let { id } = useParams();
  const GetApi = `/products/product/${id}`;
  const patchApi = `/users/addToWishlist`;
  const postAPi = `/chat/new-conversation`;
  let [ID, setID] = useState({
    prodId: id,
  });
  const { data, isPending, error } = UseAxiosGet(GetApi);
  console.log(data);
  let dataproduct = data ? data.product : "";
  let datauser = data ? data.product.seller : "";
  console.log(datauser._id);
  const [ChatData, setChatData] = useState({
    senderId: senderId,
    receiverId: "",
  });
  const {
    response: Respon,
    ErrorMessage: Error,
    data: Deta,
    HandelPostApi,
  } = UseAxiosPost(postAPi, ChatData);
  const { response, ErrorMessage, HandelPachApi } = UseAxiosPache(patchApi, ID);
  // let response_lenth = response ? response.user.length : null;
  let [Wishlist, setWishlist] = useState(false);
  async function SetWichlist() {
    HandelPachApi();
  }
  useEffect(() => {
    setChatData((prevChatData) => ({
      ...prevChatData,
      receiverId: datauser ? datauser._id : null,
    }));
    if (Respon) {
      toast(`✔️ ${Respon}`);
      setTimeout(() => {
        localStorage.setItem("ChatID", Deta.existingConv._id);
        window.location.href = "/chat";
      }, 3000);
    }
    if (Error && Respon == "") {
      toast(`❌ ${Error} `);
    }
  }, [Error, Respon, data, datauser]);

  return (
    <>
      <section>
        <Navebar />
      </section>
      <section>
        <div className="container">
          <div className="row  align-items-center justify-content-center mt-5 mb-5 ">
            <div className=" col-8   rounded-5 bg-light  ">
              <div className="row">
                <div className="col-xxl-6 col-xl-6 col-lg-4 col-md-12 col-sm-12 col-12 mb-1">
                  <div className="photo-div mt-4 ms-4   rounded-4">
                    <img
                      src={dataproduct.productImage}
                      className=" w-100 h-100 rounded-4 "
                      alt="..."
                    />
                  </div>
                </div>
                <div className="product-info col-xxl-6 col-xl-6 col-lg-8 col-md-12 col-sm-12 col-12 mt-3">
                  {Wishlist ? (
                    <div className="  text-end me-2 mt-5 ">
                      <Link
                        onClick={() => {
                          SetWichlist();
                          setWishlist(false);
                        }}
                      >
                        <ul className=" text-decoration-none">
                          <i className=" fs-1 whichlist_bg ">
                            <FaHeart />
                          </i>
                        </ul>
                      </Link>
                    </div>
                  ) : (
                    <div className="  text-end me-2 mt-5 ">
                      <Link
                        onClick={() => {
                          SetWichlist();
                          setWishlist(true);
                        }}
                      >
                        <ul className="text-decoration-none">
                          <i className=" fs-1 text-dark  ">
                            <BiHeart />
                          </i>
                        </ul>
                      </Link>
                    </div>
                  )}
                  <div className="text-center">
                    <h3 className="">{dataproduct.productName}</h3>
                    <h6 className="mt-5">Price: {dataproduct.price}</h6>
                    <h4 className="mt-3">Product Details</h4>
                    <p className=" mt-3   ">{dataproduct.description}</p>
                  </div>
                  <div className="row mt-5">
                    <div className=" offset-2 col-12">
                      <h6>Uploaded By:- {datauser.fullName} </h6>
                    </div>
                    <div className=" offset-2 col-3  ">
                      <img
                        src={datauser.userImage}
                        alt=""
                        className="w-100 dataitem_img  rounded-circle"
                      />
                    </div>
                    <div className="col-6 mt-2">
                      <Link to={`/SellerInfo/${datauser._id}/${id}`}>
                        <button className="btn btn-primary">show more</button>
                      </Link>
                    </div>
                  </div>

                  <div className="mt-1 mb-3 text-center">
                    <button onClick={HandelPostApi} className=" btn-items">
                      contact
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <ToastContainer />
      </section>
      <section>
        <Footer />
      </section>
    </>
  );
}
