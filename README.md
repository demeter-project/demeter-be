# Demeter-Be
## Turing Backend Engineering Group Project
![ruby](https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white) ![ror](	https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white) ![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)
#### Contributors: [Thomas Musselman](https://github.com/musselmanth) | [Riley McCullough](https://github.com/Rileybmcc) | [Sid Mann](https://github.com/sjmann2) | [A.J. Krumholz](https://github.com/ajkrumholz) | [Ken Lenhart](https://github.com/ajkrumholz)

### Description:
A RESTful API backend that consumes the [National Oceanic and Atmospheric Administration](https://www.noaa.gov/) weather API and the [Growstuff](https://www.growstuff.org/) gardening API.

#### Directions

[GitHub Repo](https://github.com/demeter-project/demeter-be)

`bundle install`

`rails db:{drop,create,migrate,seed}`

`rails s`

#### Endpoints available

**Get one plant**

GET `http://localhost:3000/api/v1/plants/<plant_id>`




