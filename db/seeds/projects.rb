logger.progname = 'Seed - Projects'

logger.info 'Create - Initial seed project'
Project.create project_status: ProjectStatus.where(key: 'forming').first,
            name: 'Project',
            pitch: 'Project pitch.',
            description: 'Project description.'
