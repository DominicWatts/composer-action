# Magento 2 Docker Composer with tagged PHP versions for command line use, Git Hub actions, Git Lab CI

## Why build another one image?

Actually, I want to follow DRY principle and use official [Composer](https://hub.docker.com/_/composer) image. But see the following composer.json:

```json
{
    "require": {
        "php": ">=5.5.9"
    },
    "require-dev": {
        "phpunit/phpunit": "^4 | ^5 | ^6"
    }
}
```

And use the following workflow:

```yaml
- name: Composer install
  uses: docker://composer:1.9.1
  with:
    args: install
- name: PHPUnit testing
  uses: docker://php:5.5
  with:
    args: php vendor/bin/phpunit
```

It's expected to work on PHP 5.5 ~ 7.3, so we should test on every platform. However, Composer image will install on PHP 7.3 platform and it will install PHPUnit 6.x. It will failed on PHP 5.5 container for PHPUnit 6.x require [PHP ^7.0](https://packagist.org/packages/phpunit/phpunit#6.0.0).   

Of course, we can use the `config.platform.php` config to force platform version on PHP 5.5 and it will install PHPUnit 4.x, but PHPUnit 4.x use too many deprecated functions, e.g. [each()](https://www.php.net/manual/en/function.each.php), so that cannot work on PHP >=7.2.

Finally, I think that build image on every version is the good idea.

## Usage for GitHub Actions

Via GitHub Workflow

```yaml
- uses: DominicWatts/composer-action@master
  with:
    args: install
```

Use install image

```yaml
- uses: DominicWatts/composer-action/install@master
```

With specify PHP version

```yaml
- uses: DominicWatts/composer-action/5.5/install@master
```

## Usage for Docker

See [Docker Hub](https://hub.docker.com/r/domw/composer/)

    docker run --rm -v $PWD:/app domw/composer:7.0

    docker run --rm -v $PWD:/app domw/composer:7.1

    docker run --rm -v $PWD:/app domw/composer:7.2

    docker run --rm -v $PWD:/app domw/composer:7.3

    docker run --rm -v $PWD:/app domw/composer:7.4

## Supported tags and respective `Dockerfile` links

* [`7.4` (7.4/Dockerfile)](domwhttps://github.com/dominicwatts/composer-action/blob/master/7.4/Dockerfile)
* [`7.3` (7.3/Dockerfile)](domwhttps://github.com/dominicwatts/composer-action/blob/master/7.3/Dockerfile)
* [`7.2` (7.2/Dockerfile)](domwhttps://github.com/dominicwatts/composer-action/blob/master/7.2/Dockerfile)
* [`7.1` (7.1/Dockerfile)](domwhttps://github.com/dominicwatts/composer-action/blob/master/7.1/Dockerfile)
* [`7.0` (7.0/Dockerfile)](domwhttps://github.com/dominicwatts/composer-action/blob/master/7.0/Dockerfile)

## Credits

* [MilesChou](https://github.com/MilesChou)

## License

The MIT License (MIT). Please see [License File](LICENSE) for more information.
