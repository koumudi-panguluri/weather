class WeatherList {
  String description;
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  double pressure;
  double humidity;
  int visibility;
  int sunRise;
  int sunset;
  int timezone;
  String name;
  WeatherList(
      {this.description,
      this.temp,
      this.feelsLike,
      this.tempMax,
      this.tempMin,
      this.pressure,
      this.humidity,
      this.visibility,
      this.sunRise,
      this.sunset,
      this.timezone,
      this.name});
}
