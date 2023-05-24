import 'package:mobile/resources/resources.dart';

String getImageCode(dynamic code, DateTime timeFromZone, bool day) {

  if(code == 0){
    if(day){
      return Images.sunlight;
    }else{
      if(timeFromZone.hour >= 6 && timeFromZone.hour <= 19){
        return Images.sunlight;
      }else{
        return Images.stars2;
      }
    }
  }
  if(code == 1){
    if(day){
      return Images.sunCloud;
    }else{
      if(timeFromZone.hour >= 6 && timeFromZone.hour <= 19) {
        return Images.sunCloud;
      }else{
        return Images.night;//nightCloud
      }
    }
  }
  if(code == 2){
    if(day){
      return Images.cloudy2;
    }else {
      if(timeFromZone.hour >= 6 && timeFromZone.hour <= 19) {
        return Images.cloudy2;
      }else {
        return Images.nightCloud;//nightCloud
      }
    }
  }
  if(code == 3){
    return Images.overcast;
  }
  if(code == 45){
    return Images.haze;
  }
  if(code == 48){
    return Images.haze;
  }
  if(code == 51){
    return Images.rain;
  }
  if(code == 53){
    return Images.rain;
  }
  if(code == 55){
    if(day){
      return Images.rain3;
    }else{
      if(timeFromZone.hour >= 6 && timeFromZone.hour <= 19) {
        return Images.rain3;
      }else{
        return Images.rain2;
      }
    }
  }
  if(code == 56){
    return Images.sprinkle;
  }
  if(code == 57){
    return Images.sprinkle;
  }
  if(code == 61){
    return Images.rainDrops1;
  }
  if(code == 63){
    return Images.rainDrops2;
  }
  if(code == 65){
    return Images.rain3;
  }
  if(code == 66){
    return Images.rain;
  }
  if(code == 67){
    return Images.rain3;
  }
  if(code == 71){
    return Images.snow1;
  }
  if(code == 73){
    return Images.snow2;
  }
  if(code == 75){
    return Images.snow3;
  }
  if(code == 77){
    return Images.snow;
  }
  if(code == 80){
    return Images.rain4;
  }
  if(code == 81){
    return Images.rain4;
  }
  if(code == 82){
    return Images.rain4;
  }
  if(code == 85){
    return Images.snow;
  }
  if(code == 86){
    return Images.snow;
  }
  if(code == 95){
    return Images.thunderstorm;
  }
  if(code == 96){
    return Images.thunderstorm;
  }
  if(code == 99){
    return Images.rain5;
  } else {
    return Images.cloud;
  }
}


String getStringCode(dynamic code, DateTime timeFromZone){
  if(code == 0){
    if(timeFromZone.hour >= 6 && timeFromZone.hour <= 19){
      return "Ensoleillé";
    }else{
      return "Nuits étoilé";
    }
  }
  if(code == 1){
    return "Plutôt dégagé";
  }
  if(code == 2){
    return "Partiellement nuageux";
  }
  if(code == 3){
    return "Couvert";
  }
  if(code == 45){
    return "Brouillard";
  }
  if(code == 48){
    return "brouillard givré";
  }
  if(code == 51){
    return "Bruine légère";
  }
  if(code == 53){
    return "Bruine modérée";
  }
  if(code == 55){
    return "Bruine dense";
  }
  if(code == 56){
    return "Bruine verglaçante";
  }
  if(code == 57){
    return "Bruine verglaçante";
  }
  if(code == 61){
    return "Faible pluie";
  }
  if(code == 63){
    return "Pluie modérée";
  }
  if(code == 65){
    return "Forte pluie";
  }
  if(code == 66){
    return "Pluie verglaçante";
  }
  if(code == 67){
    return "Pluie verglaçante";
  }
  if(code == 71){
    return "Neige légère";
  }
  if(code == 73){
    return "Neige modérée";
  }
  if(code == 75){
    return "Neige forte";
  }
  if(code == 77){
    return "Grains de neige";
  }
  if(code == 80){
    return "Averses Légères";
  }
  if(code == 81){
    return "Averses modérées ";
  }
  if(code == 82){
    return "Averses violentes";
  }
  if(code == 85){
    return "Averses de neige légères";
  }
  if(code == 86){
    return "Averses de neige fortes";
  }
  if(code == 95){
    return "Orage";
  }
  if(code == 96){
    return "Orage avec grêle";
  }
  if(code == 99){
    return "Orage fort";
  } else {
    return "N/A";
  }
}


String getWeakDay(int day){

  if(day > 7){
    day = day -7;
  }

  switch (day){
    case 1:
      return "Lundi";
    case 2:
      return "Mardi";
    case 3:
      return "Mercredi";
    case 4:
      return "Jeudi";
    case 5:
      return "Vendredi";
    case 6:
      return "Samedi";
    case 7:
      return "Dimanche";
    default:
      return "N/A";
  }
}