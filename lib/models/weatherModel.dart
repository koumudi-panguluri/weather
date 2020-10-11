class WeatherList {
  final String main;
  final String description;
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final double pressure;
  final double humidity;
  final int visibility;
  final String country;
  final int sunRise;
  final int sunset;
  final int timezone;
  final String name;
  WeatherList(
      {this.main,
      this.description,
      this.temp,
      this.feelsLike,
      this.tempMax,
      this.tempMin,
      this.pressure,
      this.humidity,
      this.visibility,
      this.country,
      this.sunRise,
      this.sunset,
      this.timezone,
      this.name});
}
