# Results Center

A Rails application for displaying election results in real-time. This project is part of the ElectionBuddy coding challenge focused on building a modern Results Center dashboard.

---
## READ ME!

Use this README to document your ideas, progress, and any other relevant information about your implementation.

Please replace the current content of this README with details specific to your project. Clearly explain your design decisions, implementation approach, and any unique features or challenges you encountered. This will help reviewers understand your thought process and evaluate your work effectively.

---

## Challenge Guidelines

Visit the [ElectionBuddy challenge page](https://github.com/electionbuddy/results-center-guidelines) for detailed requirements and guidelines.

If you are a candidate specializing in a foreign programming language, this project serves as an excellent foundation for implementing the Results Center in your language of choice. Alternatively, you can use it as an opportunity to explore and learn Ruby on Rails.

## Getting Started

### Prerequisites

- Ruby 3.4+
- Rails 8+
- PostgreSQL
- Docker (optional but recommended)

### Quick Start with Docker

This project uses [drun.sh](https://github.com/Rynaro/drun) - a simple Docker runner for Rails development.

```bash
# Start the application
./drun.sh up

# Or build and run
./drun.sh build
./drun.sh up
```

### Manual Setup

```bash
# Install dependencies
bundle install

# Setup database
rails db:setup

# Start server
rails server
```

## Welcome Page

Visit the root path (`/`) to see the welcome page with:
- Complete database schema setup commands
- Expected JSON API response format
- Ballot data structure examples
- Project overview and mission statement

## Database Schema

The application includes the following models:

- **Election**: Core election with title, status, and timing
- **Question**: Individual questions/races within an election
- **Answer**: Possible choices for each question
- **Voter**: Registered voters with access tokens
- **Ballot**: Individual ballot submissions with tally data

## Docker Runner

This project uses [drun.sh](https://github.com/Rynaro/drun) for streamlined Docker-based development. Common commands:

```bash
./drun.sh help          # Show all available commands
./drun.sh up            # Start containers
./drun.sh down          # Stop containers
./drun.sh shell         # Open Rails console
./drun.sh clean         # Clean up containers and volumes
```

## License

This project is part of the ElectionBuddy coding challenge.
