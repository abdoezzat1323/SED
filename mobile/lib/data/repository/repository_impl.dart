import 'package:dartz/dartz.dart';
import 'package:sed/data/mapper/mapper.dart';
import 'package:sed/data/network/error_handler.dart';
import 'package:sed/data/network/failure.dart';
import 'package:sed/data/network/network_info.dart';
import 'package:sed/data/network/requests.dart';
import 'package:sed/data/source/remote_data_source.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      //device is connected to the internet, call api
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          //success
          //return data
          //return either right
          return Right(response.toDomain());
        } else {
          //failure
          //return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      //return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.forgotPassword(email);

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success
          return Right(response.toDomain());
        } else {
          //failure
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      //return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      //device is connected to the internet, call api
      try {
        final response = await _remoteDataSource.register(registerRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success , return data
          return Right(response.toDomain());
        } else {
          //failure
          //return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      //return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Home>> getHomeData() async {
    if (await _networkInfo.isConnected) {
      //device is connected to the internet, call api
      try {
        final response = await _remoteDataSource.getHomeData();

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success , return data
          return Right(response.toDomain());
        } else {
          //failure
          //return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      //return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Item>> getItemData(int itemId) async {
    if (await _networkInfo.isConnected) {
      //device is connected to the internet, call api
      try {
        final response = await _remoteDataSource.getItemData(itemId);

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success , return data
          return Right(response.toDomain());
        } else {
          //failure
          //return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      //return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, ShowItems>> getShowItems(
      ShowItemsRequest showItemsRequest) async {
    if (await _networkInfo.isConnected) {
      //device is connected to the internet, call api
      try {
        final response =
            await _remoteDataSource.getShowItemsData(showItemsRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success , return data
          return Right(response.toDomain());
        } else {
          //failure
          //return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      //return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, SavingProduct>> toggleSavingProduct(
      SavingProductRequest savingProductRequest) async {
    if (await _networkInfo.isConnected) {
      //device is connected to the internet, call api
      try {
        final response =
            await _remoteDataSource.toggleSavingProduct(savingProductRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success , return data
          return Right(response.toDomain());
        } else {
          //failure
          //return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      //return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, ShowItems>> getShowProfile(
      ShowProfileRequest showProfileRequest) async {
    if (await _networkInfo.isConnected) {
      //device is connected to the internet, call api
      try {
        final response =
            await _remoteDataSource.getShowProfile(showProfileRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success , return data
          return Right(response.toDomain());
        } else {
          //failure
          //return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      //return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, AddAdvertisement>> addAdvertisement(
      AddAdvertisementRequest addAdvertisementRequest) async {
    if (await _networkInfo.isConnected) {
      //device is connected to the internet, call api
      try {
        final response =
            await _remoteDataSource.addAdvertisement(addAdvertisementRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success , return data
          return Right(response.toDomain());
        } else {
          //failure
          //return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      //return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, GetMyProfileData>> getMyProfileData(String token) async{
    if (await _networkInfo.isConnected) {
      //device is connected to the internet, call api
      try {
        final response =
            await _remoteDataSource.getMyProfileData(token);

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success , return data
          return Right(response.toDomain());
        } else {
          //failure
          //return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      //return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
