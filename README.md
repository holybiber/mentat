# Docker-based wrapper to run Mentat
[Mentat](https://github.com/AbanteAI/mentat) is an AI tool that assists with any coding task directly from the command line.

This projects makes it easier to use it: In the command line, go into whatever coding directory you want to use mentat with.
Then just type `mentat` and you're ready to go! (without needing to worry about a python and mentat installation on your computer). Mentat will make commits in your git name or you can let it use a custom git configuration.

## Setup
1. Clone this repository
2. Add a file `.env` with your OpenAI API key (`OPENAI_API_KEY=sk-...` - see [.env.example](.env.example))

Simplify usage so that you don't have to call it with the full path `/path/to/mentat/bin/mentat` every time:
- Create a symlink from [bin/mentat](bin/mentat) into your `$PATH` so that you can easily run the wrapper script from anywhere on your computer, e.g. `ln -s /path/to/mentat/bin/mentat ~/.local/bin/mentat`

## Configuration
This wrapper can automatically use your [Mentat configuration](https://docs.mentat.ai/en/latest/user/configuration.html). E.g. you can create a `~/.mentat/.mentat_config.json` with
```
{
    "model": "gpt-4-1106-preview"
}
```
and Mentat will always use this model. Alternatively add a per-project `.mentat-config.json` into the directory you want to work on.

By default mentat will make commits with the same git name as if you would make a git commit (by reading `~/.gitconfig`). You can change that by specifying another config file it should use: `GITCONFIG=/path/to/.gitconfig mentat`

## Usage
In the command line: Go into the directory containing the code you want to work on with Mentat. Start the wrapper script `bin/mentat` - if you created the symlink you just need to type `mentat`. Mentat will spin up and you can ask your questions. No files are automatically added to the context because context would quickly get large (queries can get more expensive) / too large - add the files/folders you want to have as context with `/include ...`. See the [Mentat Readme](https://github.com/AbanteAI/mentat) for further information and introduction videos

## Explanations
`Dockerfile`: The container is based on Debian and is also available on Docker Hub: [holybiber/mentat](https://hub.docker.com/repository/docker/holybiber/mentat/general). I decided for Debian to make it easier to integrate Firefox / Chromium in the future.

`docker-compose.yml`: Docker compose setup, make git and mentat configuration available to the container

`bin/mentat`: Wrapper for docker compose to be able to run mentat easily

## Contributing
This is a first working version - feedback and suggestions welcome.

### Known issues:
Mentat's `/screenshot` functionality isn't working yet (it didn't work by just installing `firefox-esr` or `chromium` into the docker container)