logger.progname = 'Seed - Ideas'

logger.info 'Truncate'
Idea.truncate

logger.info 'Create - Ideation platform'
Idea.create name: 'Ideation platform',
            idea_status: IdeaStatus.where(key: 'started').first,
            pitch: 'Exposing common interest and drawing out pockets of excellence (ideation platform)',
            description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam pellentesque sagittis
interdum. Phasellus faucibus, mauris at scelerisque aliquam, diam lectus facilisis mauris, eu egestas diam leo placerat
elit. Proin vehicula cursus rhoncus. Fusce facilisis eu nibh sed convallis. Etiam interdum nulla vel est elementum
sodales. Ut congue arcu eget velit condimentum facilisis. Praesent id euismod arcu, id egestas dui. Nunc aliquet
suscipit ex at pharetra. Proin condimentum sit amet mauris at interdum. Vivamus posuere augue ut aliquet maximus.
Donec vitae eros eget justo bibendum sodales id sit amet elit. In hac habitasse platea dictumst. Maecenas tincidunt
faucibus eleifend. Vivamus rutrum cursus pretium. Ut tristique lacus odio. Donec aliquam orci mauris, vitae gravida
lorem malesuada et.

Duis ipsum erat, scelerisque ac quam non, gravida pellentesque ante. Vivamus quam nulla, interdum ut mi a, posuere
malesuada magna. Fusce consectetur dapibus luctus. Nam sed leo in eros hendrerit porttitor ac eu mauris. Cras non
suscipit sapien. Sed dignissim, arcu quis porttitor iaculis, leo augue sodales diam, quis viverra eros sapien quis
ipsum. Proin volutpat tellus quis lectus aliquet tincidunt. Integer mollis laoreet vehicula. Nulla nulla orci,
lobortis nec dapibus ut, ullamcorper eu arcu. Ut et condimentum nunc. Quisque faucibus, sem sed tempor pharetra, felis
ex interdum risus, vitae commodo arcu urna dignissim arcu. Suspendisse condimentum, augue a laoreet iaculis, lectus
neque ultrices massa, sed dignissim magna turpis eget augue. Lorem ipsum dolor sit amet, consectetur adipiscing elit.

Donec rutrum neque metus, et varius neque pellentesque nec. Nunc nunc velit, elementum non venenatis at, fermentum vel
justo. Aliquam neque ligula, ultrices ut mauris ac, ultrices porttitor nisl. In id pulvinar ipsum. Maecenas varius
convallis porta. Nam tempor, ligula et ullamcorper sodales, risus dui eleifend mauris, vel vulputate nisi neque vel
justo. Nunc eget nulla et felis sodales consequat.'

logger.info 'Create - Collaboration training programs (conceptualization)'
Idea.create name: 'Training programs to improve collaboration capabilities',
            idea_status: IdeaStatus.where(key: 'concept').first,
            pitch: 'Programs that offer interested parties a chance to become better participants and leaders of
collaborations',
            description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam pellentesque sagittis
interdum. Phasellus faucibus, mauris at scelerisque aliquam, diam lectus facilisis mauris, eu egestas diam leo placerat
elit. Proin vehicula cursus rhoncus. Fusce facilisis eu nibh sed convallis. Etiam interdum nulla vel est elementum
sodales. Ut congue arcu eget velit condimentum facilisis. Praesent id euismod arcu, id egestas dui. Nunc aliquet
suscipit ex at pharetra. Proin condimentum sit amet mauris at interdum. Vivamus posuere augue ut aliquet maximus.
Donec vitae eros eget justo bibendum sodales id sit amet elit. In hac habitasse platea dictumst. Maecenas tincidunt
faucibus eleifend. Vivamus rutrum cursus pretium. Ut tristique lacus odio. Donec aliquam orci mauris, vitae gravida
lorem malesuada et.'

logger.info 'Create - Quarterly mobile meetings (abandoned)'
Idea.create name: 'Quarterly mobile meetings',
            idea_status: IdeaStatus.where(key: 'abandoned').first,
            pitch: 'Getting everyone together in a physical location to talk mobile strategy'